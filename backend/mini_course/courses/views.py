from django.shortcuts import render
from rest_framework.permissions import IsAuthenticated, IsAdminUser, AllowAny
from django_filters import rest_framework as dj_filters
from rest_framework import filters as rest_filters
from rest_framework import viewsets
from . import serializers
from . import filters
from .models import Course, Lesson

class CourseViewSet(viewsets.ModelViewSet): 
    queryset = Course.objects.all()
    serializer_class = serializers.ShortCourseSerializer
    filter_backends = (dj_filters.DjangoFilterBackend,rest_filters.SearchFilter,)
    filterset_class = filters.CourseFilter
    permission_classes = [AllowAny]
    search_fields = ['title']

    def get_serializer_class(self):
        if self.action == 'retrieve': 
            return serializers.SimpleCourseSerializer
        return super().get_serializer_class()
    


