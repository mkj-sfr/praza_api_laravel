<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Invoice>
 */
class InvoiceFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'price' => $this->faker->randomFloat(1, 10, 100),
            'billing_id' => $this->faker->randomNumber(9, true),
            'payment_id' => $this->faker->randomNumber(9, true),
            'payment_method' => $this->faker->randomElement(['debit', 'portal']),
            'user_id' => $this->faker->numberBetween(1, 10),
            'status' => $this->faker->boolean()
        ];
    }
}
