<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ClassCourseController;
use App\Http\Controllers\CounselController;
use App\Http\Controllers\CounselingTypeController;
use App\Http\Controllers\CourseCategoryController;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\DiscountCodeController;
use App\Http\Controllers\FileController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\PlatformController;
use App\Http\Controllers\SessionController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\SubTaskController;
use App\Http\Controllers\UploadController;
use App\Http\Controllers\PaymentController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PageController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Protected routes
Route::group(['middleware' => ['auth:sanctum']], function () {

});
// TODO: make middleware for role protected routes

Route::middleware('auth:sanctum')->prefix('/v1')->group(function () {
    Route::prefix('/auth')->group(function () {
        Route::withoutMiddleware('auth:sanctum')->group(function () {
            Route::post('/register', [AuthController::class, 'register']);
            Route::post('/login', [AuthController::class, 'login']);
            Route::post('/login_with_code', [AuthController::class, 'login_with_code']);
            Route::post('/send_verification_code', [AuthController::class, 'send_verification_code']);
            Route::post('/reset_password', [AuthController::class, 'reset_password']);
            Route::post('/reset_password_code_confirm', [AuthController::class, 'reset_password_code_confirm']);
            Route::get('/unauthorized', function () {
                return response()->json([
                    'message' => 'Unauthorized user access!',
                    'http_status' => 403,
                ]);
            })->name('unauthorized');
        });
        Route::post('/logout', [AuthController::class, 'logout']);
    });
    Route::prefix('/platforms')->group(function () {
        Route::post('/show_by_type', [PlatformController::class, 'show_by_type']);
        Route::post('/show_single', [PlatformController::class, 'show_single']);
        Route::post('/create', [PlatformController::class, 'create']);
        Route::post('/update', [PlatformController::class, 'update']);
        Route::post('/delete', [PlatformController::class, 'delete']);
    });

    Route::prefix('/counseling_types')->group(function () {
        Route::post('/', [CounselingTypeController::class, 'show']);
        Route::post('/show_single', [CounselingTypeController::class, 'show_single']);
        Route::post('/create', [CounselingTypeController::class, 'create']);
        Route::post('/update', [CounselingTypeController::class, 'update']);
        Route::post('/delete', [CounselingTypeController::class, 'delete']);
    });

    Route::prefix('/upload')->group(function () {
        Route::post('/', [UploadController::class, 'show']);
        Route::post('/create', [UploadController::class, 'create']);
        Route::post('/update', [UploadController::class, 'update']);
        Route::post('/delete', [UploadController::class, 'delete']);
    });

    Route::prefix('/payment')->group(function () {
        Route::post('/', [PaymentController::class, 'show']);
        Route::post('/create', [PaymentController::class, 'create']);
    });
    Route::prefix('/files')->group(function () {
        Route::post('/', [FileController::class, 'show']);
        Route::post('/show_single', [FileController::class, 'show_single']);
        Route::post('/create', [FileController::class, 'create']);
        Route::post('/update', [FileController::class, 'update']);
        Route::post('/status_switch', [FileController::class, 'status_switch']);
        Route::post('/delete', [FileController::class, 'delete']);

        Route::prefix('/tasks')->group(function () {
            Route::post('/', [TaskController::class, 'show']);
            Route::post('/show_single', [TaskController::class, 'show_single']);
            Route::post('/create', [TaskController::class, 'create']);
            Route::post('/update', [TaskController::class, 'update']);
            Route::post('/delete', [TaskController::class, 'delete']);

            Route::prefix('/sub_tasks')->group(function () {
                Route::post('/', [SubTaskController::class, 'show']);
                Route::post('/show_single', [SubTaskController::class, 'show_single']);
                Route::post('/create', [SubTaskController::class, 'create']);
                Route::post('/update', [SubTaskController::class, 'update']);
                Route::post('/delete', [SubTaskController::class, 'delete']);
                Route::post('/status_switch', [SubTaskController::class, 'status_switch']);
            });
        });
    });
    Route::prefix('/invoices')->group(function () {
        Route::post('/', [InvoiceController::class, 'show']);
        Route::post('/show_invoice_payments', [InvoiceController::class, 'show_invoice_payments']);
        Route::post('/validate_price', [InvoiceController::class, 'validate_price']);
        Route::post('/register_invoice_from_cart', [InvoiceController::class, 'register_invoice_from_cart']);
        Route::post('/register_invoice', [InvoiceController::class, 'register_invoice']);
        Route::post('/validate_invoice', [InvoiceController::class, 'validate_invoice']);
    });

    Route::post('/send_sms_collection', [UserController::class, 'send_sms_collection']);

    Route::prefix('/course_category')->group(function () {
        Route::post('/', [CourseCategoryController::class, 'show']);
        Route::post('/show_single', [CourseCategoryController::class, 'show_single']);
        Route::post('/create', [CourseCategoryController::class, 'create']);
        Route::post('/update', [CourseCategoryController::class, 'update']);
        Route::post('/status_switch', [CourseCategoryController::class, 'status_switch']);
        Route::post('/delete', [CourseCategoryController::class, 'delete']);
    });
    Route::prefix('/profile')->group(function () {
        Route::prefix('/my_courses')->group(function () {
            Route::post('/', [CourseController::class, 'my_courses']);
            Route::post('/my_course_details', [CourseController::class, 'show_single']);
        });
    });
    Route::prefix('/manage_courses')->group(function () {
        Route::post('/', [CourseController::class, 'show']);
        Route::post('/show_single', [CourseController::class, 'show_single']);
        Route::post('/course_buyers', [CourseController::class, 'course_buyers']);
        Route::post('/course_buyer_info', [CourseController::class, 'course_buyer_info']);
        Route::post('/course_payments', [CourseController::class, 'course_payments']);
        Route::post('/not_confirmed_course_payments', [CourseController::class, 'not_confirmed_course_payments']);
        Route::post('/course_payment_confirm', [CourseController::class, 'course_payment_confirm']);
        Route::post('/create', [CourseController::class, 'create']);
        Route::post('/update', [CourseController::class, 'update']);
        Route::post('/status_switch', [CourseController::class, 'status_switch']);
        Route::post('/course_buyer_send_sms', [CourseController::class, 'course_buyer_send_sms']);
        Route::post('/delete', [CourseController::class, 'delete']);
    });

    Route::prefix('/classes')->group(function () {
        Route::post('/', [ClassCourseController::class, 'show']);
        Route::post('/show_by_user_role', [ClassCourseController::class, 'show_by_user_role']);
        Route::post('/show_single', [ClassCourseController::class, 'show_single']);
        Route::post('/create', [ClassCourseController::class, 'create']);
        Route::post('/update', [ClassCourseController::class, 'update']);
        Route::post('/delete', [ClassCourseController::class, 'delete']);
    });

    Route::prefix('/discount_codes')->group(function () {
        Route::post('/', [DiscountCodeController::class, 'show']);
        Route::post('/show_single', [DiscountCodeController::class, 'show_single']);
        Route::post('/create', [DiscountCodeController::class, 'create']);
        Route::post('/update', [DiscountCodeController::class, 'update']);
        Route::post('/delete', [DiscountCodeController::class, 'delete']);
    });

    Route::prefix('/counsels')->group(function () {
        Route::post('/', [CounselController::class, 'show']);
        Route::post('/show_by_user_role', [CounselController::class, 'show_by_user_role']);
        Route::post('/show_single', [CounselController::class, 'show_single']);
        Route::post('/create', [CounselController::class, 'create']);
        Route::post('/update', [CounselController::class, 'update']);
        Route::post('/delete', [CounselController::class, 'delete']);
    });

    Route::prefix('/cart')->group(function () {
        Route::post('/', [CartController::class, 'show']);
        Route::post('/create', [CartController::class, 'create']);
        Route::post('/delete', [CartController::class, 'delete']);
        Route::post('/delete_all', [CartController::class, 'delete_all']);
    });
    Route::prefix('/manage_users')->group(function () {
        Route::post('/', [UserController::class, 'show']);
        Route::post('/show_single', [UserController::class, 'show_single']);
        Route::post('/create', [UserController::class, 'create']);
        Route::post('/update', [UserController::class, 'update']);
        Route::post('/status_switch', [UserController::class, 'status_switch']);
        Route::post('/send_sms', [UserController::class, 'send_sms']);
        Route::post('/show_payments', [UserController::class, 'show_payments']);
        Route::post('/set_role', [UserController::class, 'set_role']);
        Route::post('/delete', [UserController::class, 'delete']);
    });

    Route::prefix('/sessions')->group(function () {
        Route::post('/show_user_sessions', [SessionController::class, 'show_user_sessions']);
        Route::post('/create', [SessionController::class, 'create']);
        Route::post('/update', [SessionController::class, 'update']);
        Route::post('/delete', [SessionController::class, 'delete']);
    });

    Route::prefix('/manage_roles')->group(function () {
        Route::post('/', [RoleController::class, 'show']);
        Route::post('/show_single', [RoleController::class, 'show_single']);
        Route::post('/create', [RoleController::class, 'create']);
        Route::post('/update', [RoleController::class, 'update']);
        Route::post('/delete', [RoleController::class, 'delete']);
        Route::post('/page_attach', [RoleController::class, 'page_attach']);
        Route::post('/page_detach', [RoleController::class, 'page_detach']);
    });

    Route::prefix('/manage_pages')->group(function () {
        Route::post('/', [PageController::class, 'show']);
        Route::post('/show_single', [PageController::class, 'show_single']);
        Route::post('/create', [PageController::class, 'create']);
//        Route::post('/update', [PageController::class, 'update']);
        Route::post('/delete', [PageController::class, 'delete']);
    });
});
