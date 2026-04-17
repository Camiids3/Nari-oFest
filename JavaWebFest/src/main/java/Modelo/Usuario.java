package Modelo;

public class Usuario {
    private static int contadorId = 1;
    
    private String Nombre;
    private int Edad;
    private String Correo;
    private String Contraseña;
    private String Rol;
    private int IdUsuario;

    //Constructor Metodo
    public Usuario(String Nombre, int Edad, String Correo, String Contraseña, String Rol) {
        this.Nombre = Nombre;
        this.Edad = Edad;
        this.Correo = Correo;
        this.Contraseña = Contraseña;
        this.Rol = Rol;
        this.IdUsuario = contadorId;
        contadorId++;
    }
    //get and set 

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public int getEdad() {
        return Edad;
    }

    public void setEdad(int Edad) {
        this.Edad = Edad;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    public String getContraseña() {
        return Contraseña;
    }

    public void setContraseña(String Contraseña) {
        this.Contraseña = Contraseña;
    }

    public String getRol() {
        return Rol;
    }

    public void setRol(String Rol) {
        this.Rol = Rol;
    }

    public int getIdUsuario() {
        return IdUsuario;
    }
    //Metodos 
    private boolean validarDatos(String Nombre, int Edad, String Contraseña, String Rol, String Correo) {
        if (Nombre == null || Nombre.isEmpty()) {
            return false;
        }
        if (Correo == null || Correo.isEmpty()) {
            return false;
        }
        if (Contraseña == null || Contraseña.isEmpty()) {
            return false;
        }
        if (Rol == null || Rol.isEmpty()) {
            return false;
        }
        if (Edad <= 0) {
            return false;
        }
        return true;
    }

    public boolean registrarUsuario(String Nombre, int Edad, String Contraseña, String Rol, String Correo) {

        if (!validarDatos(Nombre, Edad, Contraseña, Rol, Correo)) {
            return false;
        }

        for (int i = 0; i < BaseDatos.listaUsuarios.size(); i++) {

            Usuario u = BaseDatos.listaUsuarios.get(i);

            if (u.getCorreo().equals(Correo)) {
                return false;
            }
        }

        BaseDatos.listaUsuarios.add(this);
        return true;

    }

    public static Usuario iniciarSesion(String Correo, String Contraseña) {
        for (Usuario u : BaseDatos.listaUsuarios) {

            if (u.getCorreo().equals(Correo)
                    && u.getContraseña().equals(Contraseña)) {

                return u; 
            }
        }

        return null; 
    }
    public String mostrarPerfil() {

    return "Nombre: " + this.Nombre +
           "\nEdad: " + this.Edad +
           "\nCorreo: " + this.Correo +
           "\nRol: " + this.Rol +
           "\nID: " + this.IdUsuario;
}
}