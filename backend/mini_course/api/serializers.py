from rest_framework import serializers
from .models import Course, Lesson, Enrollment
from django.contrib.auth.models import User

class CourseSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Course
        fields = (
            'id',
            'title', 
            'description',
            'image', 
            'total_duration'
        )


class LessonForCourseDetailSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Lesson
        fields = ('name', 'video_duration')


class CourseDetailSerializer(serializers.ModelSerializer):
    lesson_set = LessonForCourseDetailSerializer(many=True)
    class Meta: 
        model = Course
        fields = (
            'id',
            'title',
            'description',
            'image',
            'total_duration', 
            'lesson_set'
        )

class UserSerializer(serializers.ModelSerializer):
    class Meta: 
        model = User
        fields = (
            'id',
            'username'
        )

class EnrollmentSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only =True)
    course = CourseSerializer(read_only=True)
    class Meta: 
        model = Enrollment
        fields = (
            'user',
            'course',
            'progress', 
            'completed', 
            'certificate_issued', 
            'rating', 
            'created_at', 
        )


