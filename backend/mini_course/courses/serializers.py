from rest_framework import serializers
from .models import Course, Lesson
from django.contrib.auth.models import User


class SimpleCourseSerializer(serializers.ModelSerializer):
    class LessonSerializer(serializers.ModelSerializer): 
        class Meta: 
            model = Lesson
            fields = (
                'course', 
                'name',
                'video_duration',
                'url',
            )
    lesson_set = LessonSerializer(many=True, read_only=True)

    class Meta: 
        model = Course
        fields = (
            'id',
            'title', 
            'image', 
            'total_duration',
            'description',
            'gener', 
            'total_lessons',
            'lesson_set',
            'total_duration',
        )

class ShortCourseSerializer(serializers.ModelSerializer): 
    class Meta: 
        model = Course
        fields = (
            'id', 
            'title',
            'image',
            'total_duration',
        )

