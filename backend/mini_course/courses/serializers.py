from rest_framework import serializers
from .models import Course, Lesson
from django.contrib.auth.models import User

class SimpleCourseSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Course
        fields = (
            'id',
            'title', 
            'image', 
            'total_duration',
            'description',
            'gener', 
        )


class LessonSerializer(serializers.ModelSerializer): 
    class Meta: 
        model = Lesson
        fields = (
            'course', 
            'name',
            'video_duration',
        )