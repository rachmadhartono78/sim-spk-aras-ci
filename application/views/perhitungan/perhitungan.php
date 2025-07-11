<?php
$this->load->view('layouts/header_admin');

// Matrix Keputusan (X)
$matriks_x = array();
foreach ($alternatifs as $alternatif):
    foreach ($kriterias as $kriteria):
        $id_alternatif = $alternatif->id_alternatif;
        $id_kriteria = $kriteria->id_kriteria;

        if (!isset($matriks_x[$id_kriteria])) {
            $matriks_x[$id_kriteria] = [];
        }

        $data_pencocokan = $this->Perhitungan_model->data_nilai($id_alternatif, $id_kriteria);
        $nilai = isset($data_pencocokan['nilai']) ? $data_pencocokan['nilai'] : 0;

        $matriks_x[$id_kriteria][$id_alternatif] = $nilai;
    endforeach;
endforeach;

// Matrix Keputusan (X0)
$matriks_x0 = array();
foreach ($kriterias as $kriteria):
    $type_kriteria = $kriteria->jenis;
    $id_kriteria = $kriteria->id_kriteria;

    if ($type_kriteria == 'Kinerja') {
        $x0 = max($matriks_x[$id_kriteria]);
    } elseif ($type_kriteria == 'Risiko') {
        $x0 = min($matriks_x[$id_kriteria]);
    } else {
        $x0 = 0; // Default jika tidak ada tipe kriteria
    }

    $matriks_x0[$id_kriteria] = $x0;
endforeach;

// Matrix Keputusan (X2)
$matriks_x2 = array();
foreach ($alternatifs as $alternatif):
    foreach ($kriterias as $kriteria):
        $id_alternatif = $alternatif->id_alternatif;
        $id_kriteria = $kriteria->id_kriteria;
        $x = $matriks_x[$id_kriteria][$id_alternatif];
        $type_kriteria = $kriteria->jenis;

        if ($type_kriteria == 'Kinerja') {
            $x2 = $x;
        } elseif ($type_kriteria == 'Risiko') {
            $x2 = ($x != 0) ? 1 / $x : 0; // Hindari pembagian dengan nol
        } else {
            $x2 = 0;
        }

        $matriks_x2[$id_kriteria][$id_alternatif] = $x2;
    endforeach;
endforeach;

// Matrix Keputusan (X02)
$matriks_x02 = array();
foreach ($kriterias as $kriteria):
    $id_kriteria = $kriteria->id_kriteria;
    $type_kriteria = $kriteria->jenis;
    $x0 = $matriks_x0[$id_kriteria];

    if ($type_kriteria == 'Kinerja') {
        $x02 = $x0;
    } elseif ($type_kriteria == 'Risiko') {
        $x02 = ($x0 != 0) ? 1 / $x0 : 0; // Hindari pembagian dengan nol
    } else {
        $x02 = 0;
    }

    $matriks_x02[$id_kriteria] = $x02;
endforeach;

$total_matriks_x = array();
foreach ($kriterias as $kriteria):
    $tx = 0;
    $id_kriteria = $kriteria->id_kriteria;
    foreach ($alternatifs as $alternatif):
        $id_alternatif = $alternatif->id_alternatif;
        $x = $matriks_x2[$id_kriteria][$id_alternatif];
        $tx += $x;
    endforeach;
    $x0 = $matriks_x02[$id_kriteria];
    $total_matriks_x[$id_kriteria] = $tx + $x0;
endforeach;

// Normalisasi Matriks Keputusan
$matriks_r = array();
foreach ($alternatifs as $alternatif):
    foreach ($kriterias as $kriteria):
        $id_alternatif = $alternatif->id_alternatif;
        $id_kriteria = $kriteria->id_kriteria;
        $x = $matriks_x2[$id_kriteria][$id_alternatif];
        $total = $total_matriks_x[$id_kriteria];

        $matriks_r[$id_kriteria][$id_alternatif] = ($total != 0) ? $x / $total : 0; // Hindari pembagian dengan nol
    endforeach;
endforeach;

$matriks_r0 = array();
foreach ($kriterias as $kriteria):
    $id_kriteria = $kriteria->id_kriteria;
    $x0 = $matriks_x02[$id_kriteria];
    $total = $total_matriks_x[$id_kriteria];

    $matriks_r0[$id_kriteria] = ($total != 0) ? $x0 / $total : 0; // Hindari pembagian dengan nol
endforeach;

// Matriks Normalisasi Terbobot
$matriks_rb = array();
$total_rb = array();
foreach ($alternatifs as $alternatif):
    $t_rb = 0;
    $id_alternatif = $alternatif->id_alternatif;
    foreach ($kriterias as $kriteria):
        $id_kriteria = $kriteria->id_kriteria;
        $bobot = $kriteria->bobot;
        $r = $matriks_r[$id_kriteria][$id_alternatif];
        $rb = $r * $bobot;
        $matriks_rb[$id_kriteria][$id_alternatif] = $rb;
        $t_rb += $rb;
    endforeach;
    $total_rb[$id_alternatif] = $t_rb;
endforeach;

$matriks_rb0 = array();
$total_rb0 = 0;
foreach ($kriterias as $kriteria):
    $id_kriteria = $kriteria->id_kriteria;
    $r0 = $matriks_r0[$id_kriteria];
    $bobot = $kriteria->bobot;
    $rb = $r0 * $bobot;
    $matriks_rb0[$id_kriteria] = $rb;
    $total_rb0 += $rb;
endforeach;
?>

<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-info"><i class="fa fa-table"></i> Perhitungan Nilai Akhir</h6>
    </div>

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" width="100%" cellspacing="0">
                <thead class="bg-info text-white">
                    <tr align="center">
                        <th>Alternatif</th>
                        <th width="30%">Nilai S</th>
                        <th width="30%">Nilai K</th>
                    </tr>
                </thead>
                <tbody>
                    <tr align="center">
                        <td>X<sub>0</sub></td>
                        <td><?= $total_rb0;?></td>
                        <td><?= ($total_rb0 != 0) ? $total_rb0 / $total_rb0 : 0; ?></td>
                    </tr>
                    <?php 
                        $no=1;
                        $this->Perhitungan_model->hapus_hasil();
                        foreach ($alternatifs as $alternatif):
                        $id_alternatif = $alternatif->id_alternatif;
                    ?>
                    <tr align="center">
                        <td>X<sub><?= $no; ?></sub></td>
                        <td><?= $total_rb[$id_alternatif]; ?></td>
                        <td><?= ($total_rb0 != 0) ? $total_rb[$id_alternatif] / $total_rb0 : 0; ?></td>
                    </tr>
                    <?php
                        $no++;
                        $nilai = ($total_rb0 != 0) ? $total_rb[$id_alternatif] / $total_rb0 : 0;
                        $hasil_akhir = [
                            'id_alternatif' => $id_alternatif,
                            'nilai' => $nilai,
                        ];
                        $this->Perhitungan_model->insert_hasil($hasil_akhir);
                        endforeach;
                    ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php
$this->load->view('layouts/footer_admin');
?>
