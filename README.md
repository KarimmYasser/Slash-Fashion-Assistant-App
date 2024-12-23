# Fashion Assistant App

The **Fashion Assistant App** is an all-in-one platform designed to enhance the shopping experience for users while empowering local fashion brands. Combining innovative technology with user-centric design, the app provides features like avatar creation, AI-driven recommendations, and streamlined brand management interfaces.

---

## Key Features

### User Features:
- **Interactive Registration**:
  - Collects user measurements with a guided interface that visually highlights body areas.
  - Integration with [Ready Player Me](https://readyplayer.me) for creating personalized avatars.

- **Personalized Recommendations**:
  - A chatbot assistant that learns user preferences and suggests tailored fashion items.
  - AI-powered search for text-based and image-based queries.

- **Product Browsing**:
  - Horizontally scrollable product rows under an animated app bar.
  - Interactive product cards with detailed information and quick actions.

- **Shopping Features**:
  - Add items to a wishlist or directly to the cart.
  - Secure and seamless checkout process.

- **Customer Support**:
  - A dedicated chat interface for resolving user inquiries.

### Brand Features:
- **Product Management**:
  - Add, update, and manage products with ease.
  - Upload product images, descriptions, and pricing details.

- **Offer Management**:
  - Create and manage promotional offers directly within the app.

- **Insights & Engagement**:
  - View user interactions and respond to inquiries.

### Admin Features:
- **User & Brand Oversight**:
  - Manage user accounts, brand registrations, and permissions.

- **Offer Approvals**:
  - Review and approve offers submitted by brands.

- **System Monitoring**:
  - Oversee app performance and resolve escalated issues.

---

## Technology Stack

- **Frontend**: Flutter for a smooth cross-platform experience.
- **Backend**: Node.js with Express.js for robust API handling.
- **Database**: PostgreSQL for secure and efficient data management.
- **Avatar Integration**: Ready Player Me for avatar creation and customization.
- **AI Features**: Custom algorithms for tailored recommendations and searches.

---

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yarafarouk/fashion-assistant-app.git
   cd fashion-assistant-app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   npm install
   ```

3. **Setup Database**:
   - Create a PostgreSQL database.
   - Run the provided migration scripts to set up tables.

4. **Run the Application**:
   - Start the backend:
     ```bash
     npm start
     ```
   - Run the frontend:
     ```bash
     flutter run
     ```

---

## Screenshots

### User Screens
- **Home Screen**:
  ![Home Screen](screenshots/home_screen.png)

- **Avatar Creation**:
  <div style="display: flex; justify-content: space-between;">
  <img src="![Screenshot_20241223_154030_com example fashion_assistant](https://github.com/user-attachments/assets/c36b896e-b1cd-49bd-ac05-1b628089b352)" alt="Home Screen" width="30%"/>
  <img src="![Screenshot_20241223_154041_com example fashion_assistant](https://github.com/user-attachments/assets/c48cf6d3-8e41-40b8-919b-4e87e3d15113)" alt="Avatar Creation" width="30%"/>
  <img src="![Screenshot_20241223_154107_com example fashion_assistant](https://github.com/user-attachments/assets/ef488a3f-eb51-4624-95e5-6e4ecfa537ae)" alt="Fashion Suggestions" width="30%"/>
</div>
<div style="display: flex; justify-content: space-between;">
  <img src="![Screenshot_20241223_154134_com example fashion_assistant](https://github.com/user-attachments/assets/98817841-f2f0-43a5-8186-4ec65124125c)" alt="Home Screen" width="30%"/>
  <img src="!![Screenshot_20241223_154217_com example fashion_assistant](https://github.com/user-attachments/assets/fffb994b-89c5-4277-bc6f-4bd5f7421d4f)" alt="Avatar Creation" width="30%"/>
 </div>

- **Fashion Suggestions**:
  ![Fashion Suggestions](screenshots/fashion_suggestions.png)

- **Product Listing**:
  ![Product Listing](screenshots/product_listing.png)

- **Cart and Checkout**:
  ![Cart and Checkout](screenshots/cart_checkout.png)

### Brand Screens
- **Dashboard**:
  ![Brand Dashboard](screenshots/brand_dashboard.png)

- **Add Product**:
  ![Add Product](screenshots/add_product.png)

- **Manage Offers**:
  ![Manage Offers](screenshots/manage_offers.png)

### Admin Screens
- **Admin Dashboard**:
  ![Admin Dashboard](screenshots/admin_dashboard.png)

- **User Management**:
  ![User Management](screenshots/user_management.png)

- **Offer Approval**:
  ![Offer Approval](screenshots/offer_approval.png)

### Customer Service Screens
- **Chat Interface**:
  ![Customer Service Chat](screenshots/customer_service_chat.png)

---

## Contribution Guidelines

We welcome contributions from the community. To contribute:

1. Fork the repository.
2. Create a new branch for your feature:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

Enjoy a seamless shopping experience and empower your fashion brand with the **Fashion Assistant App**!
