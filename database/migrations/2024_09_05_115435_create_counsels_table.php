<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('counsels', function (Blueprint $table) {
            $table->id();
            $table->string('slug');
            $table->foreignId('counseling_type_id')->constrained();
            $table->unsignedBigInteger('session_id')->nullable();
            $table->foreign('session_id')->references('id')->on('user_available_sessions')->nullOnDelete();
            $table->unsignedBigInteger('client_id');
            $table->foreign('client_id')->references('id')->on('users');
            $table->unsignedBigInteger('counselor_id');
            $table->foreign('counselor_id')->references('id')->on('users');
            $table->boolean('status')->default(false);
            $table->foreignId('platform_id')->nullable()->constrained()->nullOnDelete();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('counsels');
    }
};
