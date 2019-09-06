<?php
/**
 * @copyright Copyright (c) Global Network Group
 */
namespace modules\services;

use craft\base\Component;

/**
 * class Calculator
 *
 * @author Global Network Group | Giel Tettelaar <giel@yellowflash.net>
 */
class Calculator extends Component
{
    /**
     * @param int $a
     * @param int $b
     * @return int
     */
    public function add(int $a, int $b) : int
    {
        return $a + $b;
    }

    /**
     * @param int $a
     * @param int $b
     * @return int
     */
    public function multiply(int $a, int $b) : int
    {
        return $a * $b;
    }
}
