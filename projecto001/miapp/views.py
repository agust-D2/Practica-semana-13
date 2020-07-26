from django.shortcuts import render, HttpResponse
from django.shortcuts import redirect

# Create your views here.
layout ="""
    <h1>Proyecto Web (LP3 ) | Nathan Silvera</h1>
    <hr>
    <u1>
        <li>
            <a href="/inicio">Inicio</a>
        </li>
        <li>
            <a href="/saludo">Mensaje de Saludo</a>
        </li>
        <li>
            <a href="/rango">Mostrar Numeros [a,b]</a>
        </li>
    </u1>
    </hr>
"""

def index(request):
    return render(request, 'index.html')

def login(request):
    return render(request, 'login.html')

def registro(request):
    return render(request, 'register.html')

def rango2(request, a, b):
    resultado= f"""
        <h2>Numeros de [{a},{b}]</h2>
        resultado: <br>
        <u1>
    """
    while a<=b:
        resultado+= f"<li>{a}</li>"
        a+=1
    resultado+="</u1>"
    return HttpResponse(layout + resultado)

def rango(request,a=10,b=20):
    if a>b:
        return redirect('rango', a=b, b=a)

    resultado= f"""
        <h2>Numeros de [{a},{b}]</h2>
        resultado: <br>
        <u1>
    """
    while a<=b:
        resultado+= f"<li>{a}</li>"
        a+=1
    resultado+="</u1>"
    return HttpResponse(layout + resultado)

#segundo metodo
def saludo(request):
    return render(request, 'saludo.html')

#primer metodo
def saludo1(request):
    mensaje="""
        <h1> Bienvenidos </h1>
        <h2> atte. Silvera Iñigo, Nathan </h2>
    """
    return HttpResponse(layout + mensaje)