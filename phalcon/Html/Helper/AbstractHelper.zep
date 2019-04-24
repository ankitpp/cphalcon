
/**
 * This file is part of the Phalcon Framework.
 *
 * (c) Phalcon Team <team@phalconphp.com>
 *
 * For the full copyright and license information, please view the LICENSE.txt
 * file that was distributed with this source code.
 */

namespace Phalcon\Html\Helper;

use Phalcon\Di;
use Phalcon\DiInterface;
use Phalcon\Escaper;
use Phalcon\Html\Exception;
use Phalcon\EscaperInterface;

/**
 * Phalcon\Html\Helper\AbstractHelper
 *
 * Abstract class for all html helpers
 */
abstract class AbstractHelper
{
    /**
     * @var <EscaperInterface>
     */
    protected escaper;

    /**
     * Constructor
     */
    public function __construct()
    {
        let this->escaper = new Escaper();
    }

    /**
     * Keeps all the attributes sorted - same order all the tome
     */
    protected function orderAttributes(array overrides, array attributes) -> array
    {
        var intersect, results;
        array order;

        let order = [
            "rel"    : null,
            "type"   : null,
            "for"    : null,
            "src"    : null,
            "href"   : null,
            "action" : null,
            "id"     : null,
            "name"   : null,
            "value"  : null,
            "class"  : null
        ];

        let intersect = array_intersect_key(order, attributes),
            results   = array_merge(intersect, attributes),
            results   = array_merge(overrides, results);

        /**
         * Just in case remove the "escape" attribute
         */
        unset results["escape"];

        return results;
    }

    /**
     * Renders all the attributes
     */
    protected function renderAttributes(array attributes) -> string
    {
        var key, value;
        string result;

        let result = "";

        for key, value in attributes {
            if typeof key == "string" && value !== null {
                if unlikely (typeof value == "array" || typeof value == "resource" || typeof value == "object") {
                    throw new Exception(
                        "Value at index: '" . key . "' type: '" . gettype(value) . "' cannot be rendered"
                    );
                }

                let result .= key . "=\"" . this->escaper->escapeHtmlAttr(value) . "\" ";
            }
        }

        return result;
    }

    /**
     * Renders an element
     */
    protected function renderElement(string tag, string text, array attributes = [])
    {
        var attrs, escapedText;
        string escapedAttrs;

        let escapedAttrs = "",
            escapedText  = this->escaper->escapeHtml(text);

        if (count(attributes) > 0) {
            let attrs        = this->orderAttributes([], attributes),
                escapedAttrs = " " . rtrim(this->renderAttributes(attrs));
        }

        return "<" . tag . escapedAttrs . ">" . escapedText . "</" . tag. ">";
    }

    /**
     * Produces a self close tag i.e. <img />
     */
    protected function selfClose(string tag, array attributes = [])
    {
        var attrs;
        string escapedAttrs;

        let escapedAttrs = "";

        if (count(attributes) > 0) {
            let attrs        = this->orderAttributes([], attributes),
                escapedAttrs = " " . rtrim(this->renderAttributes(attrs));
        }

        return "<" . tag . escapedAttrs . "/>";
    }
}
