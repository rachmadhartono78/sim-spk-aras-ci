<?php
    
    defined('BASEPATH') OR exit('No direct script access allowed');
    
    class User_model extends CI_Model {

        public function tampil()
        {
            $query = $this->db->get('user');
            return $query->result();
        }

        public function insert($data = [])
        {
            $result = $this->db->insert('user', $data);
            return $result;
        }

        public function show($id_user)
        {
            $this->db->where('id_user', $id_user);
            $query = $this->db->get('user');
            return $query->row();
        }

        public function update($id_user, $data = [])
        {
            $ubah = array(
                'id_user_level' => $data['id_user_level'],
                'email' => $data['email'],
				'nama'  => $data['nama'],
                'username'  => $data['username'],
                'password'  => $data['password']
            );

            $this->db->where('id_user', $id_user);
            $this->db->update('user', $ubah);
        }

        public function delete($id_user)
        {
            $this->db->where('id_user', $id_user);
            $this->db->delete('user');
        }

        public function get_user()
        {
            $query = $this->db->get('user');
            return $query->result();
        }
        public function user_level()
        {
            $query = $this->db->get('user_level');
            return $query->result();
        }         
        

        public function register_user($username, $password)
        {
            // Pastikan username belum ada dalam database
            $this->db->where('username', $username);
            $query = $this->db->get('users');  // Sesuaikan dengan nama tabel Anda

            if ($query->num_rows() > 0) {
                return false;  // Username sudah terdaftar
            }

            // Jika username belum ada, masukkan data pengguna baru
            $data = [
                'username' => $username,
                'password' => $password,  // Pastikan password sudah di-hash
                'id_user_level' => 2,     // Misalnya level pengguna biasa, sesuaikan dengan level Anda
            ];

            return $this->db->insert('users', $data);  // Sesuaikan dengan nama tabel Anda
            }
        }

    
    /* End of file Kategori_model.php */
    