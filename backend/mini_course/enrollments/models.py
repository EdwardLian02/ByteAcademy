from django.db import models
from django.contrib.auth.models import User
from courses.models import Course
from django.core.exceptions import ValidationError

# Create your models here.
class Enrollment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='enrollment_set')
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='enrollment_set')
    progress = models.FloatField(default=0.0)
    completed = models.BooleanField(default=False)
    certificate_issued = models.BooleanField(default=False)
    rating = models.PositiveSmallIntegerField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def validate_rating(self, value):
        if value < 0 and value > 5:
            raise ValidationError('Rating must be between 0 - 5')

    class Meta: 
        unique_together = ('user', 'course')