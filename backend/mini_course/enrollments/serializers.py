from rest_framework import serializers
from courses.serializers import SimpleCourseSerializer, ShortCourseSerializer
from .models import Course, Enrollment
from django.contrib.auth.models import User

class CreateEnrollmentSeriailizer(serializers.ModelSerializer): 
    class Meta: 
        model = Enrollment
        fields = (
            'user',
            'course', 
        )
        extra_kwargs = {
            'user': {'read_only': True}
        }

    def validate(self, attrs):
        user = self.context['request'].user 
        course = attrs['course']
        print(attrs)
        if Enrollment.objects.filter(user= user , course = course).exists():
            raise serializers.ValidationError('You have already enrolled this course')

        return super().validate(attrs)
    
    
class EnrollmentSerializer(serializers.ModelSerializer): 
    course = ShortCourseSerializer()

    class Meta: 
        model = Enrollment
        fields = (
            'user',
            'course', 
            'id',
            'progress', 
            'completed', 
            'certificate_issued', 
            'rating', 
            'created_at'
        )

        extra_kwargs = {
            "created_at": {"read_only": True}, 
            "course": {"read_only": True}, 
            "id": {"read_only": True},
            "user": {"read_only": True},
        }

    def validate_rating(self,value): 
        if value < 0 or value >5: 
            raise serializers.ValidationError("Rating should be between 0 and 5")
        
        return value


class ShortEnrollmentSerializer(serializers.ModelSerializer): 
    class Meta: 
        model = Enrollment
        fields = (
            'id', 
            'course', 
        )


