from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .mpesa import MpesaClient
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

class StkPushView(APIView):
    def post(self, request):
        phone = request.data.get('phone')
        amount = request.data.get('amount')
        job_id = request.data.get('job_id')
        callback = request.build_absolute_uri('/api/payments/mpesa-callback/')
        mpesa = MpesaClient()
        try:
            res = mpesa.stk_push(phone, amount, job_id, callback)
            return Response(res)
        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@method_decorator(csrf_exempt, name='dispatch')
class MpesaCallbackView(APIView):
    def post(self, request):
        # Safaricom will POST payment results here. Implement verification & update DB.
        # For sandbox/testing, just accept and log.
        print('MPESA CALLBACK:', request.data)
        return Response({'received': True}, status=status.HTTP_200_OK)
