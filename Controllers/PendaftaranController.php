<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PendaftaranController extends Controller
{
    public function tampil()
    {
        return response()->json(
            DB::table('pendaftaran')->get()
        );
    }

    public function tambah(Request $request)
    {
        DB::table('pendaftaran')->insert([
            'id_anggota' => $request->id_anggota,
            'tanggal_daftar' => $request->tanggal_daftar,
            'status' => $request->status
        ]);

        return response()->json(['success' => true]);
    }

}
