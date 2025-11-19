from django.urls import path
from .views import VerifyFirebaseTokenView

urlpatterns = [
    path('verify-token/', VerifyFirebaseTokenView.as_view(), name='verify-token'),
]
