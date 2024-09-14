<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Course>
 */
class CourseFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->name(),
            'description' => $this->faker->text(),
            'slug' => $this->faker->slug(),
            'author' => $this->faker->name(),
            'platform_id' => $this->faker->numberBetween(1,5),
            'capacity' => $this->faker->numberBetween(10, 200),
            'price' => $this->faker->numberBetween(100, 1000),
            'course_category_id' => $this->faker->numberBetween(1, 3),
            'status' => $this->faker->numberBetween(0, 3),
        ];
    }
}
