#modifying where crowd level dose not exist"
from django.shortcuts import render
from .models import CrowdLevel

def home(request):
    try:
        # Try to get the latest CrowdLevel record
        crowd_level = CrowdLevel.objects.latest('updated_at')
    except CrowdLevel.DoesNotExist:
        # If no CrowdLevel exists, set crowd_level to None or a default value
        crowd_level = None

    context = {
        'crowd_level': crowd_level,
        # Add any other context variables as needed
    }
    return render(request, 'menu/home.html', context)

