
# Create your views here.
from django.shortcuts import render
from .models import Coffee, Comment

def home(request):
    coffees = Coffee.objects.all()
    comments = Comment.objects.all()
    return render(request, 'menu/home.html', {
        'coffees': coffees,
        'comments': comments,
    })

