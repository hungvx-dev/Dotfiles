# Cryptography
- Dù là sử dụng cơ chế mã hóa nào thì cũng sẽ có 2 giai đoạn:
  - Giai đoạn 1: Trao đổi khóa (key exchange/key agreement) giữa Sender - Reciver
  - Giai đoạn 2: Mã hóa và trao đổi data (exchange encrypted data/cipher)
- Tùy vào giai đoạn mà sẽ có những cách chống attach khác nhau.
  - Giai đoạn 1: Exchange key
    - Mục tiêu chính: Reciver phải xác nhận được **Key** nhận được phải là Key của chính Sender chứ ko phải ai khác.
    - Nếu như bị attach ở giai đoạn này. Reciver nhận được 1 Key giả mạo Sender'. Thì coi như fail hết.
  - Giai đoạn 2:
    - Mục tiêu chính: Reciver phải xác nhận **Encrypted Data** là của Chính Sender gửi.
    - Nếu như bị attach ở giai đoạn này. Reciver nhận được **Encrypted Data** giả mạo Sender'.
# Symmetric
- Chia sẽ cùng 1 sceret key có thể vừa để giải mã và mã hóa.
- Mục đích chính là bảo mật(che giấu) dữ liệu đảm bảo người biết.
- Các thuật toán phổ biến an toàn: AES,..
## Encrypt
- Cơ chế:
  - **_ENCRYPT_**(Plaintext(Message) + SceretKey) -> Ciphertext
  - **_ENCRYPT_**(Plaintext(Message) + SceretKey + IV/NONCE) -> Ciphertext IV/Nonce: đảm bảo cùng 1 Plaintext -> khác ciphertext IV hay Nonce là tùy vào Algorithms là gì Nhược điểm: Không đảm bảo Integrity và Authenticity ở giai đoạn 2
  - Nếu người khác nhận được Ciphertext thì sẽ sửa đổi Ciphertext.
- Để khắc phục nhược điểm đó: Dùng HMAC/MAC
  - Cơ chế:
    - **_HASH_**(Ciphertext + SecretKey') => Tag
    - **_HASH_**(Ciphertext + SecretKey' + IV/NONCE) => Tag
- Output: (CipherText và Tag và IV/NONCE)
## Decrypt
- Nhận được: (CipherText, Tag và IV/NONCE)
- Trước tiên xác thực Authenticity và Integrity
  - **_HASH_**(Ciphertext + SecretKey') => Tag'
  - **_HASH_**(Ciphertext + SecretKey' + IV/NONCE) => Tag'
  - -> So sánh: Tag' và Tag
  - Nếu giống thì CipherText là hợp lệ: vì để để hash được tag' giống tag thì phải có secretkey và ciphertext bang đầu giống nhau.
- Sau khi đảm bảo được Integrity và Authenticity thì sẽ decrypt cipher text
  - **_DECRYPT_**(Ciphertext + SceretKey) -> Plaintext(Message)
## Secret key
- Secret key có nhiều loại thường là 2 loại chính
  - Session Key: Khóa ngắn hạn thường chỉ dùng 1 lần
  - Master Key / Long-term Key: Khóa dài hạn dùng lâu dài.
# Asymmetric
- Tạo cặp khóa là: Private key và Public key.
- Quan trọng: Khóa A encrypt thì khóa B decrypt. Và có thể ngược lại Khóa A decrypt thì khóa B encrypt.
- Vậy sẽ có 2 trường hợp sử dụng khác nhau.
  - Case 1: (Bên **Server** **Encrypt** bằng Private Key) -> (Bên **Client** **Decrypt** bằng Public Key)
    - **Đây là Digital Signature: Mục đích để cho Bên Client xác thực Data là do chính Bên Server gửi.**
  - Case 2: (Bên **Client** **Encrypt** bằng Public Key) -> (Bên **Server** **Decrypt** bằng Private Key)
    - **Mục đích để Bảo mật(Che giấu) Data, chỉ Bên A sở hữu Private Key mới có thể Decrypt được**
- Case 1:
  - Digital Signature: Đảm bảo được Authenticity và Non-repudiation
  - Nếu kết hợp với hash(MAC): Đảm bảo được Integrity
    - ->  Bên B có thể Đảm bảo Data là do chính chủ của Public Key là A gửi.
  - **Quan Trọng:** Lỗ hỏng sảy ra khi bên B nhận Public key. Kẻ tấn công có thể giả mạo A gửi Data.
  - -> Cần có Cơ chế Xác thực Public Key là của chính A ko ai giả mạo được: Sử dụng PKI/CA
- Case 2:
  - Mục đích giống Symmetric. Nhưng an toàn hơn Private Key được giấu kín. Đổi lại chậm hơn về tốc độ.
## Key Pairs
- Ephemeral key pair: Tạm thời chỉ dùng 1 lần
- Static key pair: Lưu trữ lâu dài

# Hybir Asymmetric + Symmetric
- Symmetric:
  - Phase 1: Exchange **Secret Key**
    - Sử dụng Asymmetric để **Secret key**:
    - Asymmetric:
      - Phase 1: Exchange **Public Key**
        - Sử dụng cơ chế Digital Signature(EdDSA) để đảm bảo Integrity và Non repudiation
        - Sau khi Xác thực bằng Digital Signature thì đảm bảo việc:
          - **Client(Reciver)** tin tưởng **Public Key** được cung cấp bởi **Server(Sender)** là đúng.
        - Ở bước này Reciver đã Xác thực được Sender là ai. Nắm giữ PublicKey của Sender
      - **Phase 2**: Exchage data: Data ở đây là **Secret Key** của Symmetric
        - Các bên Sẽ tạo và trao đổi Secret Key
  - Phase 2:
    - Trao đổi dữ liệu
## Flow

### RSA cơ chế cũ
1. Client request đến Server(abc.com) để lấy resoure.
  - Tức là Server sẽ gửi resource về Client (Server -> Client)
  - Client cần xác thực Resource trả về là của chính Server có domain là abc.com.
2. Server tạo Public/Private Key Pair và Gửi (Server's Public Key + Cert) -> Client
3. Client verify Cert Xác nhận đó là Server domain abc.com.
4. Client tạo Session Key(Secret Key), Encrypt Session Key -> Server
5. Server Decrypt và cos được Session Key. -> Cả 2 có secret key chung
6. Từ đây dữ liệu sẽ dùng Symmetric với Secret key để mã hóa và trao đổi data.

### Ephemeral Diffie-Hellman
- 2 bên sẽ có Long-term Key pair Và Ephemeral Key pair.
- Long-term Key pair: Lưu trữ lâu dài dùng để verify Digital Signature
- Ephemeral Key pair: Tạo ra mỗi lần, dùng 1 lần: Dùng để giao tiếp và tạo Session Key(Secret Key + PFS).

1.  Client tạo *ephemeral key pair* → gửi ephemeral public key (Key Share).
2.  Server tạo *ephemeral key pair* → gửi ephemeral public key + cert (chứa *long-term public key*) + signature (ký bằng *long-term private key* để auth).
3.  Cả hai tính shared secret từ 2 ephemeral public keys (qua ECDH).
4.  Từ shared secret + handshake transcript → derive session keys (traffic keys: encrypt/decrypt dữ liệu thực tế).
