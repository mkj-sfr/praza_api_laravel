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
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->longText('description')->nullable();
            // Reduce the length of the slug column to avoid index size issues
            $table->string('slug', 191)->unique();
            $table->string('author');
            $table->foreignId('platform_id')->constrained();
            $table->integer('capacity');
            $table->string('price');
            $table->unsignedBigInteger('image')->nullable();
            $table->unsignedBigInteger('demo')->nullable();
            $table->foreignId('course_category_id')->nullable()->constrained()->nullOnDelete();
            $table->tinyInteger('status')->default(0); // 0 not active -- 1 active -- 2 started -- 3 finished
            $table->timestamp('publish_date')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('courses');
    }
};
