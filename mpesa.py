import requests
import base64
import os
from datetime import datetime

class MpesaClient:
    """Simple Daraja (M-Pesa) helper for STK Push (sandbox)."""
    def __init__(self):
        self.consumer_key = os.getenv('MPESA_CONSUMER_KEY', '')
        self.consumer_secret = os.getenv('MPESA_CONSUMER_SECRET', '')
        self.shortcode = os.getenv('MPESA_SHORTCODE', '')
        self.passkey = os.getenv('MPESA_PASSKEY', '')
        self.base_url = 'https://sandbox.safaricom.co.ke'  # sandbox

    def get_access_token(self):
        url = f"{self.base_url}/oauth/v1/generate?grant_type=client_credentials"
        r = requests.get(url, auth=(self.consumer_key, self.consumer_secret))
        r.raise_for_status()
        return r.json().get('access_token')

    def stk_push(self, phone_number, amount, account_reference, callback_url):
        token = self.get_access_token()
        timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
        password = base64.b64encode((self.shortcode + self.passkey + timestamp).encode()).decode()
        payload = {
            'BusinessShortCode': self.shortcode,
            'Password': password,
            'Timestamp': timestamp,
            'TransactionType': 'CustomerPayBillOnline',
            'Amount': str(amount),
            'PartyA': phone_number,
            'PartyB': self.shortcode,
            'PhoneNumber': phone_number,
            'CallBackURL': callback_url,
            'AccountReference': account_reference,
            'TransactionDesc': 'Payment'
        }
        headers = {'Authorization': f'Bearer {token}'}
        url = f"{self.base_url}/mpesa/stkpush/v1/processrequest"
        r = requests.post(url, json=payload, headers=headers)
        return r.json()
