<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AnggotaController;
use App\Http\Controllers\PendaftaranController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

Route::middleware('api')->group(function () {
    // API Resource untuk Anggota (CRUD lengkap)
    Route::get('/anggota', [AnggotaController::class, 'index']);
    Route::get('/anggota/{id}', [AnggotaController::class, 'show']);
    Route::post('/anggota', [AnggotaController::class, 'store']);
    Route::put('/anggota/{id}', [AnggotaController::class, 'update']);
    Route::delete('/anggota/{id}', [AnggotaController::class, 'destroy']);
    Route::get('/pendaftaran', [PendaftaranController::class, 'tampil']);
    Route::post('/pendaftaran/tambah', [PendaftaranController::class, 'tambah']);
    Route::post('/pendaftaran/hapus', [PendaftaranController::class, 'hapus']);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});