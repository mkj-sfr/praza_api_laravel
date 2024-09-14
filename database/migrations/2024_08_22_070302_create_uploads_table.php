<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('uploads', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('size');
            $table->integer('path');
            $table->string('type')->nullable(); // img, doc, vid
            $table->string('extension')->nullable();
            $table->boolean('status')->default(true);
            $table->unsignedBigInteger('upload_by')->nullable();
            $table->foreign('upload_by')->references('id')->on('users')->nullOnDelete()->cascadeOnUpdate();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('uploads');
    }
};
