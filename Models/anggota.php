<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Anggota extends Model
{
    protected $fillable = ['nama', 'telp', 'alamat', 'pupuk', 'jumlah', 'tanggal'];
}