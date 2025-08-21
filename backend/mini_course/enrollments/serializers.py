from rest_framework import serializers
from courses.serializers import CourseSerializer
from .models import Course, Enrollment


class SimpleEnrollmentSerializer(serializers.ModelSerializer):
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
