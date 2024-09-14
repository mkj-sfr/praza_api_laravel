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
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->string('price');
            $table->string('description')->nullable();
            $table->string('billing_id')->nullable();
            $table->string('payment_id')->nullable();
            $table->string('payment_method')->nullable();
            $table->tinyInteger('status')->default(0); // 0 pending -- 1 confirmed -- 2 declined
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->foreignId('course_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->foreignId('counsel_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->foreignId('class_course_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->foreignId('invoice_id')->constrained()->cascadeOnDelete()->cascadeOnUpdate();
            $table->boolean('is_trashed')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
