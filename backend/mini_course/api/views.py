from django.shortcuts import render
from rest_framework.permissions import IsAuthenticated, IsAdminUser, AllowAny
from rest_framework import generics
from rest_framework.decorators import api_view
from . import serializers
from .models import Course, Lesson, Enrollment


# @api_view(['POST'])
# def register_user(request):



class CourseListCreateAPIView(generics.ListCreateAPIView):
    queryset = Course.objects.all()
    serializer_class = serializers.CourseSerializer

    def get_permissions(self):

        self.permission_classes = [AllowAny]
        if self.request.method == 'POST':
            self.permission_classes = [IsAdminUser]

        return super().get_permissions()

class CourseDetailAPIView(generics.RetrieveAPIView):
    queryset = Course.objects.all()
    serializer_class = serializers.CourseDetailSerializer
    permission_classes = [AllowAny]
    lookup_url_kwarg = 'course_id'

class EnrollmentAPIView(generics.ListAPIView):
    queryset = Enrollment.objects.all()
    serializer_class = serializers.EnrollmentSerializer
    permission_classes = [IsAuthenticated]
    