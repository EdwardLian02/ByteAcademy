from django.shortcuts import render
from rest_framework.permissions import IsAuthenticated, IsAdminUser, AllowAny
from rest_framework import viewsets
from . import serializers
from .models import Course

class CourseViewSet(viewsets.ModelViewSet): 
    queryset = Course.objects.all()
    serializer_class = serializers.SimpleCourseSerializer
    permission_classes = [AllowAny]

