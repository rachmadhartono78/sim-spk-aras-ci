<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {
    
    public function __construct()
    {
        parent::__construct();
        $this->load->library('session');
        $this->load->model('Login_model');
        $this->load->model('User_model');
    }

    public function index()
    {
        // Cek jika user sudah login
        if ($this->Login_model->logged_id()) {
            redirect('Login/home');
        } else {
            $this->load->view('login'); // Menampilkan halaman login
        }
    }

    public function login()
    {
        // Ambil input username dan password
        $username = $this->input->post('username');
        $password = $this->input->post('password');

        // Hardcoded username dan password untuk admin
        $admin_username = 'admin';
        $admin_password = '12345';

        // Hardcoded username dan password untuk user biasa
        $user_username = 'user';
        $user_password = '54321';

        // Cek jika username dan password cocok dengan admin
        if ($username === $admin_username && $password === $admin_password) {
            // Jika login berhasil sebagai admin, set session
            $log = [
                'id_user' => 1,           // ID user untuk admin
                'username' => $admin_username,
                'id_user_level' => 1,     // Level user, misal 1 untuk admin
                'status' => 'Logged'
            ];
            $this->session->set_userdata($log); // Set session data
            redirect('Login/home'); // Arahkan ke halaman home
        } elseif ($username === $user_username && $password === $user_password) {
            // Jika login berhasil sebagai user biasa, set session
            $log = [
                'id_user' => 2,           // ID user untuk user biasa
                'username' => $user_username,
                'id_user_level' => 2,     // Level user, misal 2 untuk user biasa
                'status' => 'Logged'
            ];
            $this->session->set_userdata($log); // Set session data
            redirect('Login/home'); // Arahkan ke halaman home
        } else {
            // Jika username atau password salah
            $this->session->set_flashdata('message', 'Username atau Password Salah');
            redirect('Login'); // Kembali ke halaman login
        }
    }

    public function logout()
    { 
        // Menghancurkan sesi dan redirect ke halaman login
        $this->session->sess_destroy();
        redirect('Login');
    }

    public function home()
    { 
        // Menampilkan halaman dashboard setelah login
        $data['page'] = "Dashboard";
        $this->load->view('admin/index', $data); // Halaman home
    }
}

/* End of file Login.php */
