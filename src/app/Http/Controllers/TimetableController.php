<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TimetableController extends Controller
{
    //
    public function index()
    {

        $mondayCourses = DB::select("SELECT * FROM courses WHERE day = 1");
        $requiredCourses = DB::select("SELECT * FROM courses WHERE required = 'true' ORDER BY code ASC");

        return view('timetable' , [
            'mondayCourses' => $mondayCourses,
            'requiredCourses' => $requiredCourses,
            ]);
    }
}
