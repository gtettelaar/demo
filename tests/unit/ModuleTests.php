<?php

namespace tests;

use Codeception\Test\Unit;
use modules\Module;
use UnitTester;
use Craft;

class ModuleTests extends Unit
{
    // Public properties
    // =========================================================================

    /**
     * @var UnitTester
     */
    protected $tester;

    // Public methods
    // =========================================================================

    // Tests
    // =========================================================================

    /**
     * Test the adding of numbers
     */
    public function testAdd()
    {
        $this->assertSame(
            3,
            Module::getInstance()->calculator->add(2, 1)
        );
    }

    /**
     * Test the multiplying of numbers
     */
    public function testMultiply()
    {
        $this->assertSame(
            4,
            Module::getInstance()->calculator->multiply(2, 2)
        );
    }

    /**
     * Test the instance of the module is correct
     */
    public function testModuleLoad()
    {
        $this->assertInstanceOf(
            Module::class,
            Module::getInstance()
        );
    }
}
