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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('first_name');
            $table->string('last_name');
            $table->string('phone_number', 20)->nullable()->unique();
            // Reduce the length of the email column to avoid index size issues
            $table->string('email', 191)->nullable()->unique();
            $table->string('national_id')->nullable();
            $table->string('price')->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->boolean('status')->default(true);
            $table->unsignedBigInteger('image')->nullable();
            $table->foreignId('role_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->timestamp('role_assigned_date')->useCurrent();
            $table->timestamp('role_expire_date')->nullable();
            $table->boolean('is_trashed')->default(false);
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
