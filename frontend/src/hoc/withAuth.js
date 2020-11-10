import React, { useEffect } from 'react';
import { userService } from '@services';
import { useHistory } from 'react-router-dom';

export default function withAuth(InnerComponent) {
  return function WrapperComponent() {
    const history = useHistory();

    const checkLogin = async () => {
      try {
        const { data, status } = await userService.checkLogin();
      } catch (err) {
        history.push('/login');
      }
    };

    useEffect(() => {
      checkLogin();
    }, []);

    return <InnerComponent />;
  };
}
