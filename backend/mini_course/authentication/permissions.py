from rest_framework import permissions

class IsAdminOrOwnerOfEnrollment(permissions.BasePermission): 
   def has_permission(self, request, view):
        print('in has permission')
        if request.user.is_staff: 
            return view.action in ['list', 'retrieve']

        return True
   
   def has_object_permission(self, request, view, obj):
        print('in has object permission')
        if request.user.is_staff: 
            return True

        return obj.user == request.user
   