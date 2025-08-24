from django.db import models

class Course(models.Model): 

    class GenerChoice(models.TextChoices): 
        NONE = 'None',
        AI = 'AI', 
        GRAPHIC = 'Graphic design'
        PROGRAMMING = 'Programming Language'
        LANGUAGE = 'Language'
        SALES = 'Sale & Marketing' 
        DATA_SCIENCE = 'Data Science & Analytics'
    
    title = models.CharField(max_length=225)
    description = models.TextField()
    image = models.ImageField(upload_to='course_images/', blank = True, null=True)
    gener = models.CharField(max_length=50, choices=GenerChoice.choices, default=GenerChoice.NONE)
    
    @property
    def total_duration(self):
        lessons = self.lesson_set.all()
        return sum(lesson.video_duration for lesson in lessons)
    
    @property
    def total_lessons(self): 
        return self.lesson_set.count()
    
    def __str__(self):
        return self.title
    

class Lesson(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='lesson_set')
    name = models.CharField(max_length=225)
    video_duration = models.IntegerField() #store in minutes format
    url = models.URLField(max_length=600, default="https://www.youtube.com/watch?v=2PuFyjAs7JA&pp=ygUKdGVzdCB2aWRlbw%3D%3D")

    def __str__(self):
        return f'{self.course.title} : {self.name}'