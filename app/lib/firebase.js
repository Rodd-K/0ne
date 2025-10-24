import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY || "<apiKey>",
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN || "<authDomain>",
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID || "<projectId>",
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET || "<storageBucket>",
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID || "<messagingSenderId>",
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID || "<appId>"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
