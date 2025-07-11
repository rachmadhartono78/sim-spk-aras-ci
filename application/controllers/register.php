<?php

    // defined('BASEPATH') OR exit('No direct script access allowed');

    class Login extends CI_Controller {
        public function __construct()
        {
            parent::__construct();
            $this->load->library('session');
            $this->load->model('User_model');
        }

        public function register()
        {
            // Cek jika form di-submit
            if ($this->input->post()) {
                // Ambil data dari form
                $username = $this->input->post('username');
                $password = $this->input->post('password');
                $password_confirm = $this->input->post('password_confirm');

                // Validasi password
                if ($password !== $password_confirm) {
                    $this->session->set_flashdata('message', 'Password dan Konfirmasi Password tidak cocok.');
                    redirect('Login/register');
                }

                // Validasi username (opsional)
                $this->load->library('form_validation');
                $this->form_validation->set_rules('username', 'Username', 'required|min_length[5]|max_length[20]');
                $this->form_validation->set_rules('password', 'Password', 'required|min_length[6]');

                if ($this->form_validation->run() == FALSE) {
                    $this->load->view('register');
                } else {
                    // Hash password
                    $passwordx = ($password);

                    // Simpan pengguna baru ke database
                    $result = $this->User_model->register_user($username, $passwordx);

                    if ($result) {
                        // Pendaftaran berhasil, redirect ke halaman login
                        $this->session->set_flashdata('message', 'Pendaftaran berhasil. Silakan login.');
                        redirect('Login');
                    } else {
                        // Pendaftaran gagal
                        $this->session->set_flashdata('message', 'Gagal mendaftar. Coba lagi.');
                        redirect('Login/register');
                    }
                }
            } else {
                // Tampilkan halaman register
                $this->load->view('register');
            }
        }
    }
?>
