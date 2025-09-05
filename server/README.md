# MARINA

> Moblie App foR medIcal anNotAtion

## Server Side (Node.js + Express + MongoDB)

<div class="grid" markdown>
  <img src="https://miro.medium.com/0*-VVwL0nee9RgEhJB.png" height="175">
  <img src="https://www.gtech.com.tr/wp-content/uploads/2020/09/mongodb-nedir-1.png" height="175">
</div>

Welcome to the backend of MARINA—your soon-to-be favorite Node.js + Express app, serving up microtasks and validation data like a pro. This powers the mobile Flutter frontend and stores everything in MongoDB.

### What’s inside?

- Express-based REST API
- MongoDB for storing user annotations and tasks
- Login with JWT for auth (you know the drill)
- Microtask-oriented endpoints > assign, submit, retrieve
- UCD-based features: user progress, notifications, session handling

### Setup & Run

1. Enter the server folder:

```bash
cd server
```

2. Install dependencies:

```bash
npm install
```

3. Configure environment variables:

   - Copy .env.example to .env
   - Set variables like:
     - MONGO_URI (point to your MongoDB)
     - JWT_SECRET
     - PORT (optional—defaults to 3000)

4. Launch the dev server:

```bash
npm start
```

- that usually starts it with nodemon, auto-reloading on save.

### Why It Exists

Backend is the who’s-your-daddy of this system:

- Manages microtasks, submissions, and user data
- Validates crowd inputs and stores them cleanly
- Sends the right tasks at the right time (notifications, progress)
- Makes sure only legit users do legit tasks
