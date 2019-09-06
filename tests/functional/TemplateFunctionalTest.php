<?php

namespace tests;

use FunctionalTester;

class TemplateFunctionalTest
{
    // Public methods
    // =========================================================================

    // Tests
    // =========================================================================

    /**
     * @param FunctionalTester $I
     */
    public function testTemplate(FunctionalTester $I)
    {
        $I->amOnPage('/blogs');
        $I->seeInTitle('Blogs');
        $I->see('Blog article 1');
        $I->see('Blog article 2');
        $I->dontSee('Blog article 3');
    }
}
