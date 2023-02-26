<template>
  <div class="stars">
    <div
      class="star"
      v-for="(item, index) in starsCount"
      :key="index"
      ref="star"
    ></div>
  </div>
</template>
  
  <script>
export default {
  name: "StarBackground",
  props: {},
  data() {
    return {
      starsCount: 1200,
      distance: 800,
    };
  },
  mounted() {
    this.initStars();
  },
  methods: {
    initStars() {
      let starArr = this.$refs.star;
      starArr.forEach((item) => {
        let speed = 0.2 + Math.random() * 1;
        let thisDistance = this.distance + Math.random() * 300;
        item.style.transformOrigin = `0 0 ${thisDistance}px`;
        item.style.transform = `translate3d(0, 0, -${thisDistance}px) rotateY(${
          Math.random() * 360
        }deg) rotateX(${Math.random() * -50}deg) scale(${speed}, ${speed})`;
      });
    },
  },
};
</script>
  
  <style scoped lang="css">
@keyframes rotate {
  0% {
    transform: perspective(600px) rotateZ(20deg) rotateX(-40deg) rotateY(0);
  }
  100% {
    transform: perspective(600px) rotateZ(20deg) rotateX(-40deg)
      rotateY(-360deg);
  }
}

.stars {
  transform: perspective(500px);
  transform-style: preserve-3d;
  position: absolute;
  perspective-origin: 50% 100%;
  left: 50%;
  animation: rotate 90s infinite linear;
  bottom: -200px;
}

.star {
  width: 2px;
  height: 2px;
  background: whitesmoke;
  position: absolute;
  top: 0;
  left: 0;
  backface-visibility: hidden;
}
</style>
  