import django_filters 
from .models import Course

class CourseFilter(django_filters.FilterSet): 
    gener = django_filters.CharFilter(field_name='gener', lookup_expr='icontains')
    class Meta: 
        model = Course
        fields = ['gener']