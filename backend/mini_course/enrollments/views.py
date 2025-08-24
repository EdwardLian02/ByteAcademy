from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from .models import Enrollment
from django.contrib.auth.models import User
from . import serializers
from authentication.permissions import IsAdminOrOwnerOfEnrollment

# Create your views here.
class EnrollmentViewSet(viewsets.ModelViewSet): 
    queryset = Enrollment.objects.all()
    serializer_class = serializers.EnrollmentSerializer
    permission_classes = [IsAuthenticated, IsAdminOrOwnerOfEnrollment]
    
    #return everything if user is staff
    def get_queryset(self):
        if not self.request.user.is_staff: 
            return self.queryset.filter(user = self.request.user)
        return super().get_queryset()

    def get_serializer_class(self):
        if self.action == 'create': 
            self.serializer_class = serializers.CreateEnrollmentSeriailizer
        return super().get_serializer_class()
    
    def perform_create(self, serializer):
        serializer.save(user = self.request.user)

    

 