<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        \App\Models\Platform::factory(5)->create();
        $role = \App\Models\Role::factory(1)->create();
        \App\Models\Page::factory(3)->hasAttached($role)->create();
        $role = \App\Models\Role::factory(1)->create();
        \App\Models\Page::factory(3)->hasAttached($role)->create();
        $role = \App\Models\Role::factory(1)->create();
        \App\Models\Page::factory(3)->hasAttached($role)->create();
        \App\Models\CourseCategory::factory(1)->create();
        \App\Models\CourseCategory::factory(1)->create([
            'parent_id' => 1,
        ]);
        \App\Models\CourseCategory::factory(1)->create([
            'parent_id' => 1,
        ]);
        $course = \App\Models\Course::factory(5)->create();
        \App\Models\User::factory(30)->hasAttached($course)->create();
        $course = \App\Models\Course::factory(5)->create();
        \App\Models\User::factory(30)->hasAttached($course)->create();
        $course = \App\Models\Course::factory(5)->create();
        \App\Models\User::factory(30)->hasAttached($course)->create();
        \App\Models\File::factory(5)->create();
        \App\Models\Task::factory(15)->create();
        \App\Models\SubTask::factory(50)->create();
        \App\Models\Course::factory(5)->create();
        $invoices = \App\Models\Invoice::factory(200)->create();
        $invoices->each(function ($invoice) {
            \App\Models\Payment::factory(random_int(1, 3))->create([
                'invoice_id' => $invoice->id,
                'user_id' => $invoice->user_id,
                'course_id' => random_int(1, 10),
                'status' => $invoice->status,
                'payment_method' => $invoice->payment_method,
                'billing_id' => $invoice->billing_id,
                'payment_id' => $invoice->payment_id,
            ]);
        });






        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
