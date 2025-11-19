from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import UserSerializer
from django.contrib.auth import get_user_model
import firebase_admin
from firebase_admin import auth as firebase_auth, credentials

# Initialize firebase admin if credentials provided via env -- optional in dev
try:
    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred)
except Exception:
    pass

User = get_user_model()

class VerifyFirebaseTokenView(APIView):
    """Verify token from frontend (Firebase Auth) and create/return local user"""
    def post(self, request):
        token = request.data.get('token')
        if not token:
            return Response({'detail':'no token'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            decoded = firebase_auth.verify_id_token(token)
            uid = decoded.get('uid')
            email = decoded.get('email')
            # create or get local user
            user, created = User.objects.get_or_create(username=uid, defaults={'email':email})
            serializer = UserSerializer(user)
            return Response({'user':serializer.data})
        except Exception as e:
            return Response({'detail':str(e)}, status=status.HTTP_400_BAD_REQUEST)
