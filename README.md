# AlinmaPay PG – Native iOS Direct Demo App

This project is a **Native iOS demo application** for testing **AlinmaPay Payment Gateway (PG)** using **direct iOS SDK integration**.

It is intended for **integration testing, QA validation, and reference only**.

---

## 📱 Platform Details

- **Platform:** iOS (Native)
- **Language:** Swift
- **Integration Type:** Direct SDK
- **Xcode Version:** v26.0
- **Minimum iOS Version:** iOS 12.0

---

## 💳 Supported Payments

- Card Payments (Debit / Credit)
- Apple Pay

---

## ⚙️ Requirements

- macOS
- Xcode v26.0 or later
- Valid AlinmaPay merchant account
- Apple Pay merchant configuration (for Apple Pay testing)

---

## 🔑 Required Credentials

You must obtain the following from the **AlinmaPay Merchant Dashboard**:

| Item | Description |
|----|----|
| Terminal ID | Unique terminal identifier |
| Terminal Password | Terminal password |
| Merchant Key | Secret key for request/response hashing |

⚠️ **Never commit credentials or keys to GitHub**

---

## 🚀 How to Run

1. Clone the repository
2. Open the workspace:
   ```bash
   open DemoApp.xcworkspace
Configure merchant credentials in the app

Select a device

Run the project

🍎 Apple Pay Notes

Apple Pay works only on real devices

Apple Pay capability must be enabled in the app target

Merchant ID must match AlinmaPay configuration

🧪 Debugging

Use Xcode console logs for request and response debugging

Payment and network errors are logged for troubleshooting

⚠️ Important

This demo app is not for production use

Do not commit:

.pem, .p8, .key files

Certificates or private keys

Merchant credentials

🏦 Payment Gateway

AlinmaPay Payment Gateway (AlinmaPay PG)

📄 License

Internal use only.
All rights reserved by AlinmaPay.
