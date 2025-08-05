from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
# Create your models here.
# User, Course, Lesson, Enrollment

class Course(models.Model): 
    title = models.CharField(max_length=225)
    description = models.TextField()
    image = models.ImageField(upload_to='course_images/', blank = True, null=True)
    
    @property
    def total_duration(self):
        lessons = self.lesson_set.all()
        return sum(lesson.video_duration for lesson in lessons)

class Lesson(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='lesson_set')
    name = models.CharField(max_length=225)
    video_duration = models.IntegerField()

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