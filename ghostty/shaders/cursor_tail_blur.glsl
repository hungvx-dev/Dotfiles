// Cursor trail with motion blur for Ghostty.
//
// Ported from kitty's "cursor-trail-motion-blur" shader (Slang).
// Copyright (C) 2026 Kovid Goyal <kovid at kovidgoyal.net>
// Distributed under terms of the GPLv3 license.
//
// Differences from the kitty original:
//  - kitty hands the shader the already animated trail corners. Ghostty only
//    provides the previous and current cursor rectangles plus the time of the
//    last move, so the trail animation is recomputed here as a function of time.
//  - Motion blur samples that same function between the previous frame and
//    the current frame, which is why no per-frame state is needed.

// ── Options ─────────────────────────────────────────────────────────────

// Turn motion blur on or off. When off, only antialiasing is applied.
const bool MOTION_BLUR = true;
// Number of in-between positions blended per redraw (1..64).
const int MOTION_BLUR_SAMPLES = 16;
// Smooth the edges of the trail.
const bool ANTIALIASING = true;
// When true, the blur reaches all the way into the cursor.
const bool CONNECTED = false;

// Seconds for the leading corners and the trailing corners to reach the cursor.
const float TRAIL_DECAY_FAST = 0.10;
const float TRAIL_DECAY_SLOW = 0.40;
// Maximum opacity of the trail.
const float TRAIL_OPACITY = 0.8;
// Minimum jump (in cell heights) before a trail is drawn. Stops the trail
// from appearing while typing.
const float TRAIL_START_THRESHOLD = 0.8;
// Make the trail opaque over a transparent window background.
const bool RAISE_ALPHA_UNDER_TRANSPARENCY = true;

// ── Helpers ─────────────────────────────────────────────────────────────
// All positions are in pixels. The y axis points up (origin bottom-left).
// iCurrentCursor / iPreviousCursor: xy = top-left corner, zw = size.

float clamp01(float x) { return clamp(x, 0.0, 1.0); }
vec2 clamp01(vec2 v) { return clamp(v, vec2(0.0), vec2(1.0)); }

float min4(vec4 v) { return min(min(v.x, v.y), min(v.z, v.w)); }
float max4(vec4 v) { return max(max(v.x, v.y), max(v.z, v.w)); }

// Corner order: top-right, bottom-right, bottom-left, top-left.
void rectCorners(vec4 cursor, out vec4 xs, out vec4 ys) {
    float left = cursor.x;
    float right = cursor.x + cursor.z;
    float top = cursor.y;
    float bottom = cursor.y - cursor.w;
    xs = vec4(right, right, left, left);
    ys = vec4(top, bottom, bottom, top);
}

vec2 rectCenter(vec4 cursor) {
    return vec2(cursor.x + cursor.z * 0.5, cursor.y - cursor.w * 0.5);
}

// The four trail corners elapsed seconds after the cursor moved. Corners
// facing the direction of travel reach the new cursor quickly, the others lag.
void trailCornersAt(float elapsed, out vec4 xs, out vec4 ys) {
    vec4 previousXs, previousYs, currentXs, currentYs;
    rectCorners(iPreviousCursor, previousXs, previousYs);
    rectCorners(iCurrentCursor, currentXs, currentYs);

    vec2 travelDirection = normalize(rectCenter(iCurrentCursor) - rectCenter(iPreviousCursor));
    // Direction of each corner from the cursor center, same order as rectCorners
    vec4 cornerDirectionX = vec4(1.0, 1.0, -1.0, -1.0);
    vec4 cornerDirectionY = vec4(1.0, -1.0, -1.0, 1.0);
    vec4 alignment = cornerDirectionX * travelDirection.x + cornerDirectionY * travelDirection.y;

    vec4 leadingAmount = smoothstep(vec4(-0.25), vec4(0.25), alignment);
    vec4 decay = mix(vec4(TRAIL_DECAY_SLOW), vec4(TRAIL_DECAY_FAST), leadingAmount);
    vec4 progress = vec4(1.0) - exp(-5.0 * elapsed / decay);

    xs = mix(previousXs, currentXs, progress);
    ys = mix(previousYs, currentYs, progress);
}

// How much of the pixel centered at p lies outside the edge a->b, from 0 to 1.
// orientation is +1 for counter-clockwise triangles and -1 for clockwise.
float outsideEdge(vec2 p, vec2 a, vec2 b, float orientation) {
    vec2 e = b - a;
    // Signed distance from the edge, positive on the inner side
    float dist = orientation * (e.x * (p.y - a.y) - e.y * (p.x - a.x)) / length(e);
    if (!ANTIALIASING) return dist < 0.0 ? 1.0 : 0.0;
    return 1.0 - clamp01(0.5 + dist);
}

// The fraction of the pixel centered at p that is covered by the triangle abc.
float triangleCoverage(vec2 p, vec2 a, vec2 b, vec2 c) {
    float area = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
    // A triangle that has collapsed to a line or point covers nothing
    if (abs(area) < 1e-6) return 0.0;
    float orientation = area > 0.0 ? 1.0 : -1.0;
    return clamp01(1.0
        - outsideEdge(p, a, b, orientation)
        - outsideEdge(p, b, c, orientation)
        - outsideEdge(p, c, a, orientation));
}

// The fraction of the pixel centered at p covered by the trail quad.
// Corner order is top-right, bottom-right, bottom-left, top-left.
float trailCoverage(vec2 p, vec4 xs, vec4 ys) {
    vec2 c0 = vec2(xs.x, ys.x);
    vec2 c1 = vec2(xs.y, ys.y);
    vec2 c2 = vec2(xs.z, ys.z);
    vec2 c3 = vec2(xs.w, ys.w);
    return min(triangleCoverage(p, c0, c1, c2) + triangleCoverage(p, c0, c2, c3), 1.0);
}

// The fraction of the pixel centered at p covered by the rectangle lo..hi.
float rectCoverage(vec2 p, vec2 lo, vec2 hi) {
    if (!ANTIALIASING) {
        return (p.x >= lo.x && p.x <= hi.x && p.y >= lo.y && p.y <= hi.y) ? 1.0 : 0.0;
    }
    vec2 overlap = clamp01(min(p + 0.5, hi) - max(p - 0.5, lo));
    return overlap.x * overlap.y;
}

// ── Entry point ─────────────────────────────────────────────────────────

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 color = texture(iChannel0, fragCoord / iResolution.xy);
    fragColor = color;

    // No previous cursor yet (right after launch)
    if (iPreviousCursor.z <= 0.0 || iPreviousCursor.w <= 0.0) return;

    // Trail is finished once every corner has reached the cursor
    float elapsed = iTime - iTimeCursorChange;
    if (elapsed < 0.0 || elapsed > TRAIL_DECAY_SLOW * 1.5) return;

    // Short jumps (typing) do not get a trail
    float jumpDistance = length(rectCenter(iCurrentCursor) - rectCenter(iPreviousCursor));
    if (jumpDistance < TRAIL_START_THRESHOLD * iCurrentCursor.w) return;

    vec2 cursorLo = vec2(iCurrentCursor.x, iCurrentCursor.y - iCurrentCursor.w);
    vec2 cursorHi = vec2(iCurrentCursor.x + iCurrentCursor.z, iCurrentCursor.y);

    // Time covered by one redraw, used as the motion blur window
    float frameDelta = clamp(iTimeDelta, 1.0 / 240.0, 0.05);

    vec4 endXs, endYs, startXs, startYs;
    trailCornersAt(elapsed, endXs, endYs);
    if (MOTION_BLUR && CONNECTED) {
        rectCorners(iCurrentCursor, endXs, endYs);
    }
    if (MOTION_BLUR) {
        trailCornersAt(max(elapsed - frameDelta, 0.0), startXs, startYs);
    } else {
        startXs = endXs;
        startYs = endYs;
    }

    // This runs for every pixel on screen, so skip pixels that are outside
    // the area swept by the trail in this redraw.
    vec2 sweptLo = vec2(min(min4(startXs), min4(endXs)), min(min4(startYs), min4(endYs))) - 1.0;
    vec2 sweptHi = vec2(max(max4(startXs), max4(endXs)), max(max4(startYs), max4(endYs))) + 1.0;
    if (fragCoord.x < sweptLo.x || fragCoord.x > sweptHi.x ||
        fragCoord.y < sweptLo.y || fragCoord.y > sweptHi.y) return;

    int samples = MOTION_BLUR ? clamp(MOTION_BLUR_SAMPLES, 1, 64) : 1;
    float coverage = 0.0;
    for (int i = 0; i < samples; i++) {
        float time = MOTION_BLUR ? (float(i) + 0.5) / float(samples) : 1.0;
        coverage += trailCoverage(fragCoord, mix(startXs, endXs, time), mix(startYs, endYs, time));
    }
    coverage /= float(samples);
    // Never paint over the cursor itself, so that it renders cleanly on top.
    coverage *= 1.0 - rectCoverage(fragCoord, cursorLo, cursorHi);
    if (coverage <= 0.0) return;

    float amount = clamp01(TRAIL_OPACITY * coverage);
    float alpha = RAISE_ALPHA_UNDER_TRANSPARENCY ? mix(color.a, 1.0, amount) : color.a;
    fragColor = vec4(mix(color.rgb, iCurrentCursorColor.rgb, amount), alpha);
}
