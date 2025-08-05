from django.urls import path
from . import views

urlpatterns = [
    path('courses/', views.CourseListCreateAPIView.as_view()),    
    path('course/<int:course_id>', views.CourseDetailAPIView.as_view()),    
    path('enrollment/', views.EnrollmentAPIView.as_view()),    

]