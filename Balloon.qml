import QtQuick 2.13

Item {
    id: root
    width: 50
    height: 70
    property int hookX: root.hookX
    property int hookY: root.hookY
    property color balloonColor: "black"
    z: Math.random()
    function drawBalloon(ctx) {
        // Adapted from https://www.loganfranken.com/blog/64/html5-canvas-balloon/
        // top-left start point
        const KAPPA = (4 * (Math.sqrt(2) - 1))/3;
        const centerX = x + width/2;
        const centerY = y + height/2;
        const radius = width/2;
        const handleLength = KAPPA * radius;
        const heightDiff = (radius * 0.4);

        // inspired by https://www.loganfranken.com/blog/64/html5-canvas-balloon/

        ctx.beginPath();
        // Top Left Curve
        const topLeftCurveStartX = centerX - radius;
        const topLeftCurveStartY = centerY;

        const topLeftCurveEndX = centerX;
        const topLeftCurveEndY = centerY - radius;

        ctx.moveTo(topLeftCurveStartX, topLeftCurveStartY);
        ctx.bezierCurveTo(topLeftCurveStartX, topLeftCurveStartY - handleLength,
                          topLeftCurveEndX - handleLength, topLeftCurveEndY,
                          topLeftCurveEndX, topLeftCurveEndY);

        // Top Right Curve
        const topRightCurveStartX = centerX;
        const topRightCurveStartY = centerY - radius;

        const topRightCurveEndX = centerX + radius;
        const topRightCurveEndY = centerY;

        ctx.bezierCurveTo(topRightCurveStartX + handleLength, topRightCurveStartY,
                          topRightCurveEndX, topRightCurveEndY - handleLength,
                          topRightCurveEndX, topRightCurveEndY);

        const balloonBottomY = centerY + radius + heightDiff

        // Bottom Right Curve
        const bottomRightCurveStartX = centerX + radius;
        const bottomRightCurveStartY = centerY;

        const bottomRightCurveEndX = centerX;
        const bottomRightCurveEndY = balloonBottomY;

        ctx.bezierCurveTo(bottomRightCurveStartX, bottomRightCurveStartY + handleLength,
                          bottomRightCurveEndX + handleLength, bottomRightCurveEndY,
                          bottomRightCurveEndX, bottomRightCurveEndY);

        // Bottom Left Curve
        const bottomLeftCurveStartX = centerX;
        const bottomLeftCurveStartY = balloonBottomY;

        const bottomLeftCurveEndX = centerX - radius;
        const bottomLeftCurveEndY = centerY;

        ctx.bezierCurveTo(bottomLeftCurveStartX - handleLength, bottomLeftCurveStartY,
                          bottomLeftCurveEndX, bottomLeftCurveEndY + handleLength,
                          bottomLeftCurveEndX, bottomLeftCurveEndY);

        ctx.strokeStyle = "black"
        ctx.lineWidth = 1;
        ctx.stroke();

        ctx.fillStyle = balloonColor;
        ctx.fill();

        // Create balloon tie
        const halfTieWidth = 4;
        const tieHeight = 10;
        const tieCurveHeight = 3;

        ctx.beginPath();
        ctx.moveTo(centerX - 1, balloonBottomY);
        ctx.lineTo(centerX - halfTieWidth, balloonBottomY + tieHeight);
        ctx.quadraticCurveTo(centerX, balloonBottomY + tieCurveHeight,
                             centerX + halfTieWidth, balloonBottomY + tieHeight);
        ctx.lineTo(centerX + 1, balloonBottomY);
        ctx.fill();
        ctx.stroke();

        // create the balloon string
        ctx.beginPath();
        ctx.moveTo(centerX, y + height);
        ctx.lineTo(root.hookX , root.hookY);
        ctx.lineWidth = 1
        ctx.strokeStyle = "black"
        ctx.stroke()
    }
}


