from django import forms

class registrarse(forms.Form):
    f_nombre = forms.CharField(label='nombre', max_length=100)
    f_apellido = forms.CharField(label='apellido', max_length=100)
    f_dni = forms.CharField(label='dni', max_length=8)
    f_usuario = forms.CharField(label='usuario', max_length=50)
    f_clave = forms.CharField(label='clave', max_length=100)
