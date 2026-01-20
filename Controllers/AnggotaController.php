<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AnggotaController extends Controller
{
    // GET - Ambil semua data
    public function index()
    {
        try {
            $data = DB::table('anggota')->get();
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Gagal mengambil data',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // GET - Ambil data by ID
    public function show($id)
    {
        try {
            $data = DB::table('anggota')->where('id', $id)->first();
            
            if (!$data) {
                return response()->json([
                    'error' => 'Data tidak ditemukan'
                ], 404);
            }
            
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Gagal mengambil data',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // POST - Tambah data
    public function store(Request $request)
    {
        try {
            $request->validate([
                'nama' => 'required|string|max:255',
                'telp' => 'required|string|max:20',
                'alamat' => 'required|string',
                'pupuk' => 'required|string',
                'jumlah' => 'required|string',
                'tanggal' => 'required|string',
            ]);

            $id = DB::table('anggota')->insertGetId([
                'nama' => $request->nama,
                'telp' => $request->telp,
                'alamat' => $request->alamat,
                'pupuk' => $request->pupuk,
                'jumlah' => $request->jumlah,
                'tanggal' => $request->tanggal,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return response()->json([
                'message' => 'Data berhasil ditambahkan',
                'id' => $id
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'error' => 'Validasi gagal',
                'messages' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Gagal menambahkan data',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // PUT - Update data
    public function update(Request $request, $id)
    {
        try {
            $request->validate([
                'nama' => 'required|string|max:255',
                'telp' => 'required|string|max:20',
                'alamat' => 'required|string',
                'pupuk' => 'required|string',
                'jumlah' => 'required|string',
                'tanggal' => 'required|string',
            ]);

            $exists = DB::table('anggota')->where('id', $id)->exists();
            
            if (!$exists) {
                return response()->json([
                    'error' => 'Data tidak ditemukan'
                ], 404);
            }

            DB::table('anggota')
                ->where('id', $id)
                ->update([
                    'nama' => $request->nama,
                    'telp' => $request->telp,
                    'alamat' => $request->alamat,
                    'pupuk' => $request->pupuk,
                    'jumlah' => $request->jumlah,
                    'tanggal' => $request->tanggal,
                    'updated_at' => now(),
                ]);

            return response()->json([
                'message' => 'Data berhasil diupdate'
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'error' => 'Validasi gagal',
                'messages' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Gagal mengupdate data',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // DELETE - Hapus data
    public function destroy($id)
    {
        try {
            $exists = DB::table('anggota')->where('id', $id)->exists();
            
            if (!$exists) {
                return response()->json([
                    'error' => 'Data tidak ditemukan'
                ], 404);
            }

            DB::table('anggota')->where('id', $id)->delete();

            return response()->json([
                'message' => 'Data berhasil dihapus'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Gagal menghapus data',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}