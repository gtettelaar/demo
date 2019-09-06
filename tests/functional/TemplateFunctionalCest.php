<?php

namespace happylagertests;

use FunctionalTester;

class TemplateFunctionalCest
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
        $I->see('Blogs');
        $I->see('Blog article 1');
        $I->see('Blog article 2');
        $I->dontSee('Blog article 3');
    }
}
